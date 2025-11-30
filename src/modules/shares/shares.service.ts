import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Shares } from '@/entities';
import { CreateShareDto } from './dto/create-share.dto';
import { UpdateShareDto } from './dto/update-share.dto';

@Injectable()
export class SharesService {
  constructor(
    @InjectRepository(Shares)
    private readonly sharesRepository: Repository<Shares>,
  ) {}

  async create(createShareDto: CreateShareDto) {
    const newShare = this.sharesRepository.create({
      ...createShareDto,
    });
    const savedShare = await this.sharesRepository.save(newShare);

    return {
      status: 'success',
      message: 'Share created successfully',
      data: savedShare,
    };
  }

  async findAll(owner_id?: number) {
    const where: any = { is_deleted: 0 };

    if (owner_id) {
      where.owner_id = owner_id;
    }

    const results = await this.sharesRepository.find({
      where,
      order: { createdAt: 'DESC' },
    });

    return {
      status: 'success',
      data: results,
    };
  }

  async findOne(id: number) {
    const share = await this.sharesRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!share) {
      throw new BadRequestException('Share not found');
    }

    return {
      status: 'success',
      data: share,
    };
  }

  async update(updateShareDto: UpdateShareDto) {
    const { id, ...rest } = updateShareDto;

    const existingShare = await this.sharesRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!existingShare) {
      throw new BadRequestException('Share not found');
    }

    await this.sharesRepository.update({ id }, rest);

    return {
      status: 'success',
      message: 'Share updated successfully',
    };
  }

  async remove(id: number) {
    const existingShare = await this.sharesRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!existingShare) {
      throw new BadRequestException('Share not found');
    }

    await this.sharesRepository.update({ id }, { is_deleted: 1 });

    return {
      status: 'success',
      message: 'Share deleted successfully',
    };
  }
}
