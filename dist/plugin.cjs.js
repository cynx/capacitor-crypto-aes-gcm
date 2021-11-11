'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

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
//# sourceMappingURL=plugin.cjs.js.map
