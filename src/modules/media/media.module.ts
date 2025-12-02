import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MediaService } from './media.service';
import { MediaController } from './media.controller';
import { Media, AlbumMedia, EmailLogs, EmailAttachments } from '@/entities';
import { CommonModule } from '@/common/common.module';
import { AlbumsModule } from '../albums/albums.module';

@Module({
  imports: [TypeOrmModule.forFeature([Media, AlbumMedia, EmailLogs, EmailAttachments]), CommonModule, AlbumsModule],
  controllers: [MediaController],
  providers: [MediaService],
  exports: [MediaService],
})
export class MediaModule {}
