import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MediaService } from './media.service';
import { MediaController } from './media.controller';
import { Media, AlbumMedia } from '@/entities';
import { CommonModule } from '@/common/common.module';
import { AlbumsModule } from '../albums/albums.module';

@Module({
  imports: [TypeOrmModule.forFeature([Media, AlbumMedia]), CommonModule, AlbumsModule],
  controllers: [MediaController],
  providers: [MediaService],
  exports: [MediaService],
})
export class MediaModule {}
