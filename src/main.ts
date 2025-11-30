import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
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

  // Swagger Configuration
  const swaggerConfig = new DocumentBuilder()
    .setTitle('Cloudy API')
    .setDescription('API documentation for Cloudy - Cloud Storage and Media Management Platform')
    .setVersion('1.0')
    .addTag('auth', 'Authentication endpoints')
    .addTag('users', 'User management endpoints')
    .addTag('media', 'Media management endpoints')
    .addTag('albums', 'Album management endpoints')
    .addTag('shares', 'Sharing endpoints')
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        name: 'JWT',
        description: 'Enter JWT token',
        in: 'header',
      },
      'JWT-auth',
    )
    .build();

    // /api-docs

  const document = SwaggerModule.createDocument(app, swaggerConfig);
  SwaggerModule.setup('api-docs', app, document, {
    customSiteTitle: 'Cloudy API Docs',
    customfavIcon: 'https://nestjs.com/img/logo-small.svg',
    customCss: '.swagger-ui .topbar { display: none }',
  });

  await app.listen(port);
}
bootstrap();
