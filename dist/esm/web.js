import { WebPlugin } from '@capacitor/core';
export class CryptoWeb extends WebPlugin {
    async encrypt(options) {
        console.log('Not implemented', options);
        return { encrypted: '' };
    }
    async decrypt(options) {
        console.log('Not implemented', options);
        return { decrypted: '' };
    }
    async generateSymmetricKey() {
        console.log('Not Implemented');
        return 'Not Implemented';
    }
}
//# sourceMappingURL=web.js.map