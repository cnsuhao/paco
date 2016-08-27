package com.pacoapp.paco.net;

import android.content.Context;
import android.util.Base64;
import android.util.Log;

import com.pacoapp.paco.PacoConstants;
import com.pacoapp.paco.model.Event;
import com.pacoapp.paco.model.Experiment;
import com.pacoapp.paco.model.ExperimentProviderUtil;
import com.pacoapp.paco.model.Output;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;

/**
 * This class provides all end-to-end crypto functionality in Paco. It allows an experiment provider
 * to store all data on the server encrypted with their own public RSA key, so we are not able to
 * read the data.
 */

public class Crypto {
  public static final String ENCRYPTION_KEY = "encryptionKey";
  public static final String ENCRYPTION_IV = "encryptionIv";

  private ExperimentProviderUtil experimentProviderUtil;

  /**
   * Constructor
   * @param experimentProviderUtil An experimentProviderUtil initialized with the current app context
   */
  public Crypto(ExperimentProviderUtil experimentProviderUtil) {
    this.experimentProviderUtil = experimentProviderUtil;
  }

  /**
   * Encrypt all answers for the responses given in the event lists. Every event's Experiment is
   * checked to see whether it provides a public key. If so, the answers for the event are encrypted
   * @param events The events we would like to encrypt
   * @return The same events as were passed to the function
   * @throws NoSuchAlgorithmException If the RSA algorithm is not supported on the device
   * @throws NoSuchPaddingException If padding is not supported for RSA on the device
   */
  public List<Event> encryptAnswers(List<Event> events) {
    ArrayList<Event> encryptedEvents = new ArrayList();
    for (Event event : events) {
      try {
        encryptedEvents.add(encryptAnswers(event));
      } catch (Exception e) {
        Log.e(PacoConstants.TAG, "Exception while trying to encrypt event. Falling back to unencrypted. " + e);
        encryptedEvents.add(event);
      }
    }
    return encryptedEvents;
  }

  /**
   * Encrypt all answers for the responses in an event, if the event belongs to an experiment that
   * provides a public key. If there is no key for an experiment, the answers are left unencrypted.
   * @param event The event we would like to encrypt
   * @return The same event as was passed to the function
   * @throws NoSuchAlgorithmException If the RSA algorithm is not supported on the device
   * @throws NoSuchPaddingException If padding is not supported for RSA on the device
   */
  public Event encryptAnswers(Event event) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeySpecException, UnsupportedEncodingException, BadPaddingException, InvalidKeyException, IllegalBlockSizeException, InvalidAlgorithmParameterException {
    long experimentId = event.getExperimentServerId();
    Experiment experiment = experimentProviderUtil.getExperimentByServerId(experimentId);
    String publicKeyString = experiment.getExperimentDAO().getPublicKey();
    if (publicKeyString == null || publicKeyString == "") {
      Log.v(PacoConstants.TAG, "No public key for experiment " + experiment.getExperimentDAO().getTitle());
      return event;
    }

    Log.v(PacoConstants.TAG, "Using public key for experiment " + experiment.getExperimentDAO().getTitle() + ". Key string is " + publicKeyString);
    PublicKey publicKey = base64ToPublicKey(publicKeyString);

    // Generate symmetric key that will be used to encrypt the answers
    SecretKey secretKey = generateSymmetricKey();
    // We use a single IV for all answers. This should be sufficient for our security guarantees to hold.
    IvParameterSpec iv = generateIv();
    Log.v(PacoConstants.TAG, "Symmetric key in BASE64: " + Base64.encodeToString(secretKey.getEncoded(), Base64.NO_WRAP));
    Log.v(PacoConstants.TAG, "IV in BASE64: " + Base64.encodeToString(iv.getIV(), Base64.NO_WRAP));

    ArrayList<Output> encryptedResponses = new ArrayList();
    for (Output answer : event.getResponses()) {
      encryptedResponses.add(encryptAnswer(answer, secretKey, iv));
    }

    addKeyResponses(encryptedResponses, secretKey, iv, publicKey);

    event.setResponses(encryptedResponses);

    return event;
  }

  /**
   * Add answers containing an encrypted version of the secret key and the IV.
   * @param responses The list of responses to append our own information to
   * @param secretKey The symmetric key used to encrypt all answers
   * @param iv The initialization vector for encryption
   * @param publicKey The public key of the recipient
   */
  private void addKeyResponses(List<Output> responses, SecretKey secretKey, IvParameterSpec iv, PublicKey publicKey) throws IllegalBlockSizeException, InvalidKeyException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException {
    // Add the symmetric key as a response, encrypted with the public key of the experiment organizer
    Output keyResponse = new Output();
    keyResponse.setName(ENCRYPTION_KEY);
    byte[] secretKeyBytes = secretKey.getEncoded();
    keyResponse.setAnswer(encryptWithPublic(secretKeyBytes, publicKey));
    responses.add(keyResponse);

    // Add the IV
    Output ivResponse = new Output();
    ivResponse.setName(ENCRYPTION_IV);
    byte[] ivBytes = iv.getIV();
    ivResponse.setAnswer(encryptWithPublic(ivBytes, publicKey));
    responses.add(ivResponse);
  }

  /**
   * Encrypt a given byte array (e.g. the secret key or IV) using the public key of the recipient.
   * @param plainText The bytes to be encrypted
   * @param publicKey The public key of the recipient
   * @return A BASE64 encoded String containing the encrypted version of the symmetric key
   */
  private String encryptWithPublic(byte[] plainText, PublicKey publicKey) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
    Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
    cipher.init(Cipher.ENCRYPT_MODE, publicKey);
    byte[] encryptedBytes = cipher.doFinal(plainText);
    // NO_WRAP is used for compatibility with apache's BASE64 encoder
    String encryptedAnswer = Base64.encodeToString(encryptedBytes, Base64.NO_WRAP);
    return encryptedAnswer;
  }

  /**
   * Encrypt a single response's answer using the provided public key
   * @param response The response for which to encrypt the answer
   * @param secretKey A symmetric AES key to encrypt the answer with
   * @param iv The initialization vector for encryption
   * @return The same response as was passed to the function
   */
  private Output encryptAnswer(Output response, SecretKey secretKey, IvParameterSpec iv) throws NoSuchPaddingException, NoSuchAlgorithmException, UnsupportedEncodingException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException, InvalidAlgorithmParameterException {
    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
    cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
    String answer = response.getAnswer();
    byte[] answerBytes = answer.getBytes("UTF-8");
    byte[] encryptedBytes = cipher.doFinal(answerBytes);
    // NO_WRAP is used for compatibility with apache's BASE64 encoder
    String encryptedAnswer = Base64.encodeToString(encryptedBytes, Base64.NO_WRAP);
    Log.v(PacoConstants.TAG, "Encrypted answer for " + answer + ": " + encryptedAnswer);
    response.setAnswer(encryptedAnswer);
    return response;
  }

  /**
   * Converts a provided BASE64 encoded public key to the corresponding RSA key
   * @param publicKeyString A BASE64 encoded public key
   * @return A RSA Public Key
   */
  private PublicKey base64ToPublicKey(String publicKeyString) throws NoSuchAlgorithmException, InvalidKeySpecException, UnsupportedEncodingException {
    // NO_WRAP is used for compatibility with apache's BASE64 encoder
    byte[] decoded = Base64.decode(publicKeyString.getBytes("UTF-8"), Base64.NO_WRAP);
    X509EncodedKeySpec x509publicKey = new X509EncodedKeySpec(decoded);

    KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    return keyFactory.generatePublic(x509publicKey);
  }

  private SecretKey generateSymmetricKey() throws NoSuchAlgorithmException {
    KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
    keyGenerator.init(192);
    return keyGenerator.generateKey();
  }

  private IvParameterSpec generateIv() throws NoSuchAlgorithmException {
    SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
    // AES IV size is 128
    byte[] iv = new byte[16];
    secureRandom.nextBytes(iv);

    return new IvParameterSpec(iv);
  }
}