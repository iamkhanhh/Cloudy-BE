import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SharesService } from './shares.service';
import { SharesController } from './shares.controller';
import { Shares } from '@/entities';

@Module({
  imports: [TypeOrmModule.forFeature([Shares])],
  controllers: [SharesController],
  providers: [SharesService],
  exports: [SharesService],
})
export class SharesModule {}
