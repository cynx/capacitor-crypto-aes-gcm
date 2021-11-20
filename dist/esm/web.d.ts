import { WebPlugin } from '@capacitor/core';
import type { CryptoPlugin } from './definitions';
export declare class CryptoWeb extends WebPlugin implements CryptoPlugin {
    encrypt(options: {
        text: string;
        base64Encoded: string;
    }): Promise<{
        encrypted: string;
    }>;
    decrypt(options: {
        text: string;
        base64Encoded: string;
    }): Promise<{
        decrypted: string;
    }>;
    generateSymmetricKey(): Promise<string>;
}
