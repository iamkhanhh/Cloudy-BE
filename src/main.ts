import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { ValidationPipe } from '@nestjs/common';
import * as cors from 'cors';
import * as cookieParser from 'cookie-parser';
import { config } from 'aws-sdk';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configService = app.get(ConfigService);
  const port = configService.get('PORT');

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      // forbidNonWhitelisted: true,
      transform: true,
      transformOptions: {
        enableImplicitConversion: true
      }
    }),
  );

  app.use(cookieParser());

  app.use(cors({
    // origin: 'http://localhost:4200', 
    origin: '*', 
    // methods: 'GET,HEAD,PUT,PATCH,POST,DELETE', 
    credentials: true, 
  }));

  config.update({
    credentials: {
      accessKeyId: configService.get<string>('AWS_ACCESS_KEY'),
      secretAccessKey: configService.get<string>('AWS_SECRET_KEY'),
    },
    region: configService.get<string>('AWS_REGION'),
  });

  app.setGlobalPrefix('api/v1', { exclude: [''] });

  await app.listen(port);
}
bootstrap();
