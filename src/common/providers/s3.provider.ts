import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { S3 } from 'aws-sdk';
import * as path from 'path';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class S3Provider {
    private readonly s3Client = new S3({
        credentials: {
            accessKeyId: this.configService.get<string>('AWS_ACCESS_KEY'),
            secretAccessKey: this.configService.get<string>('AWS_SECRET_KEY'),
        },
        region: this.configService.get<string>('AWS_REGION'),
    });

    constructor(
        private readonly configService: ConfigService
    ) { }

    async generateSinglePresignedUrl(fileName: string): Promise<{ url: string; contentType: string }> {
        const contentType = this.getContentTypeFromFileName(fileName);
        const params = {
            Bucket: this.configService.get<string>('AWS_BUCKET'),
            Key: fileName,
            Expires: 60 * 5,
            // ACL: 'bucket-owner-full-control',
            ContentType: contentType,
        };
        const url = await this.s3Client.getSignedUrlPromise('putObject', params);
        return { url, contentType };
    }

    async getS3Url(fileName: string, contentType: string): Promise<string> {
        const params = {
            Bucket: this.configService.get<string>('AWS_BUCKET'),
            Key: fileName,
            Expires: 60 * 60,
            ContentType: contentType,
        };
        return this.s3Client.getSignedUrlPromise('getObject', params);
    }

    generateFileName(name: string) {
        name = name.replace(/\s/g, '_').trim();

        let extension = name.match(/\.[^.]+(\.[^.]+)?$/)?.[0] || '';
        let baseName = extension ? name.replace(extension, '') : name;

        let timeStamp = new Date().getTime().toString().trim();

        return `${baseName}-${timeStamp}-${uuidv4()}${extension}`;
    }

    /**
     * Get content type (MIME type) from file extension
     */
    getContentTypeFromFileName(fileName: string): string {
        const extension = path.extname(fileName).toLowerCase().replace('.', '');

        const mimeTypes: Record<string, string> = {
            // Images
            'jpg': 'image/jpeg',
            'jpeg': 'image/jpeg',
            'png': 'image/png',
            'gif': 'image/gif',
            'webp': 'image/webp',
            'svg': 'image/svg+xml',
            'bmp': 'image/bmp',
            'ico': 'image/x-icon',
            'tiff': 'image/tiff',
            'tif': 'image/tiff',

            // Videos
            'mp4': 'video/mp4',
            'mov': 'video/quicktime',
            'avi': 'video/x-msvideo',
            'mkv': 'video/x-matroska',
            'webm': 'video/webm',
            'flv': 'video/x-flv',
            'wmv': 'video/x-ms-wmv',
            'mpeg': 'video/mpeg',
            'mpg': 'video/mpeg',
            'm4v': 'video/x-m4v',

            // Documents
            'pdf': 'application/pdf',
            'doc': 'application/msword',
            'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            'xls': 'application/vnd.ms-excel',
            'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            'ppt': 'application/vnd.ms-powerpoint',
            'pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
            'txt': 'text/plain',
            'csv': 'text/csv',
            'rtf': 'application/rtf',

            // Archives
            'zip': 'application/zip',
            'rar': 'application/x-rar-compressed',
            '7z': 'application/x-7z-compressed',
            'tar': 'application/x-tar',
            'gz': 'application/gzip',

            // Audio
            'mp3': 'audio/mpeg',
            'wav': 'audio/wav',
            'ogg': 'audio/ogg',
            'flac': 'audio/flac',
            'aac': 'audio/aac',
            'm4a': 'audio/mp4',
            'wma': 'audio/x-ms-wma',

            // Other
            'json': 'application/json',
            'xml': 'application/xml',
            'html': 'text/html',
            'css': 'text/css',
            'js': 'application/javascript',
        };

        return mimeTypes[extension] || 'application/octet-stream';
    }
}
