import { registerPlugin } from '@capacitor/core';
const Crypto = registerPlugin('Crypto', {
    web: () => import('./web').then(m => new m.CryptoWeb()),
});
export * from './definitions';
export { Crypto };
//# sourceMappingURL=index.js.map