package com.cynx.crypto;

import android.os.Build;
import android.util.Log;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class Crypto {

    public static final int IV_LENGTH = 12;
    public static final int TAG_LENGTH = 16;
    public static final int KEY_SIZE = 256;
    public static final String CIPHER_ALGO = "AES/GCM/NoPadding";
    private static final Charset UTF_8 = StandardCharsets.UTF_8;

    public String encrypt(String text, String base64Encoded, String encodedIV) throws Exception
    {
        SecretKey key = convertStringToSecretKey(base64Encoded);
        byte[] IV = decodeIV(encodedIV);

        Cipher cipher = Cipher.getInstance(CIPHER_ALGO);
        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(TAG_LENGTH * 8 , IV);
        cipher.init(Cipher.ENCRYPT_MODE, key, gcmParameterSpec);
        byte[] cipherText = cipher.doFinal(text.getBytes(UTF_8));

        return encoderBase64(cipherText);
    }

    public String decrypt(String text, String base64Encoded, String encodedIV) throws Exception
    {
        byte[] textData = decoderBase64(text);
        SecretKey key = convertStringToSecretKey(base64Encoded);
        byte[] IV = decodeIV(encodedIV);

        Cipher cipher = Cipher.getInstance(CIPHER_ALGO);

        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(TAG_LENGTH * 8, IV);
        cipher.init(Cipher.DECRYPT_MODE, key, gcmParameterSpec);
        byte[] decryptedText = cipher.doFinal(textData);

        return new String(decryptedText, UTF_8);
    }

    public String generateSymmetricKey() throws Exception {
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
        keyGenerator.init(KEY_SIZE);
        SecretKey key = keyGenerator.generateKey();
        return convertSecretKeyToString(key);
    }

    public String generateIV() throws Exception  {
        byte[] iv = new byte[IV_LENGTH];
        SecureRandom random = new SecureRandom();
        random.nextBytes(iv);

        String encodedIV = encoderBase64(iv);
        if (encodedIV.isEmpty()) {
            throw new Exception("Unable to get IV");
        }
        return encodedIV;
    }

    public byte[] decodeIV(String iv) {
        return decoderBase64(iv);
    }

    public static SecretKey convertStringToSecretKey(String encodedKey) {
        byte[] decodedKey = decoderBase64(encodedKey);
        SecretKey originalKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");
        return originalKey;
    }

    public static String convertSecretKeyToString(SecretKey secretKey) {
        byte[] rawData = secretKey.getEncoded();
        return encoderBase64(rawData);
    }

    public static String encoderBase64(byte[] rawData) {
        String encodedKey = "";
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            encodedKey = Base64.getEncoder().encodeToString(rawData);
        }
        return encodedKey;
    }

    public static byte[] decoderBase64(String base64Encoded) {
        byte[] rawData = new byte[0];
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            rawData = Base64.getDecoder().decode(base64Encoded);
        }
        return rawData;
    }

}
