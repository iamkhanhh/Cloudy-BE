import { Global, Module } from '@nestjs/common';
import { HashingPasswordProvider } from './providers/hashing-password.provider';
import { S3Provider } from './providers/s3.provider';
import { CommonProvider } from './providers/common.provider';

@Global()
@Module({
  imports: [],
  providers: [
    HashingPasswordProvider,
    S3Provider,
    CommonProvider,
  ],
  exports: [
    HashingPasswordProvider,
    S3Provider,
    CommonProvider,
  ]
})
export class CommonModule {}
