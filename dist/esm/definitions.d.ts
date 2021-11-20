export interface CryptoPlugin {
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
