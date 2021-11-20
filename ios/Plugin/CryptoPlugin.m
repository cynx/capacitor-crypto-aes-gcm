#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(CryptoPlugin, "Crypto",
           CAP_PLUGIN_METHOD(generateSymmetricKey, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(encrypt, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(decrypt, CAPPluginReturnPromise);

)
