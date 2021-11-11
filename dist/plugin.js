var capacitorCrypto = (function (exports, core) {
    'use strict';

    const Crypto = core.registerPlugin('Crypto', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.CryptoWeb()),
    });

    class CryptoWeb extends core.WebPlugin {
        async echo(options) {
            console.log('ECHO', options);
            return options;
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        CryptoWeb: CryptoWeb
    });

    exports.Crypto = Crypto;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
