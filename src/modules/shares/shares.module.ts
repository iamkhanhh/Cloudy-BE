import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SharesService } from './shares.service';
import { SharesController } from './shares.controller';
import { Shares } from '@/entities';
import { UsersModule } from '../users/users.module';
import { MediaModule } from '../media/media.module';
import { AlbumsModule } from '../albums/albums.module';

@Module({
  imports: [TypeOrmModule.forFeature([Shares]), UsersModule, MediaModule, AlbumsModule],
  controllers: [SharesController],
  providers: [SharesService],
  exports: [SharesService],
})
export class SharesModule {}
