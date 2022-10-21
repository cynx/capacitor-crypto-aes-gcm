package com.cynx.crypto;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "Crypto")
public class CryptoPlugin extends Plugin {

    private Crypto implementation = new Crypto();

    @PluginMethod
    public void encrypt(PluginCall call)  {
        String base64Encoded = call.getString("base64Encoded");
        String text = call.getString("text");
        String iv = call.getString("encodedIV");

        if (base64Encoded == null || text == null || iv == null) {
            call.reject("encrypt:  params missing");
        }

        JSObject ret = new JSObject();
        try {
            ret.put("value", implementation.encrypt(text, base64Encoded, iv));
            call.resolve(ret);
        } catch (Exception e) {
            call.reject(e.getLocalizedMessage());
        }
    }

    @PluginMethod
    public void decrypt(PluginCall call) {
        String base64Encoded = call.getString("base64Encoded");
        String text = call.getString("text");
        String iv = call.getString("encodedIV");

        if (base64Encoded == null || text == null || iv == null) {
            call.reject("encrypt:  params missing");
        }

        JSObject ret = new JSObject();
        try {
            ret.put("value", implementation.decrypt(text, base64Encoded, iv));
            call.resolve(ret);
        } catch (Exception e) {
            call.reject(e.getLocalizedMessage());
        }
    }

    @PluginMethod
    public void generateSymmetricKey(PluginCall call) {
        try {
            JSObject ret = new JSObject();
            ret.put("value", implementation.generateSymmetricKey());
            call.resolve(ret);
        } catch (Exception e) {
            call.reject(e.getLocalizedMessage());
        }
    }

    @PluginMethod
    public void generateIV(PluginCall call) {
        try {
            JSObject ret = new JSObject();
            ret.put("value", implementation.generateIV());
            call.resolve(ret);
        } catch (Exception e) {
            call.reject(e.getLocalizedMessage());
        }
    }
}
