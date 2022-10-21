export interface CryptoPlugin {
    encrypt(options: {
        text: string;
        base64Encoded: string;
        encodedIV?: string;
    }): Promise<{
        encrypted: string;
    }>;
    decrypt(options: {
        text: string;
        base64Encoded: string;
        encodedIV?: string;
    }): Promise<{
        decrypted: string;
    }>;
    generateSymmetricKey(): Promise<string>;
    generateIV(): Promise<string>;
}
