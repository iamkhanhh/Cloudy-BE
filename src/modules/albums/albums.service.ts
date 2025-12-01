import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Like, Repository } from 'typeorm';
import { Albums } from '@/entities';
import { CreateAlbumDto } from './dto/create-album.dto';
import { UpdateAlbumDto } from './dto/update-album.dto';

@Injectable()
export class AlbumsService {
  constructor(
    @InjectRepository(Albums)
    private readonly albumsRepository: Repository<Albums>,
  ) {}

  async create(createAlbumDto: CreateAlbumDto, userId: number) {
    const newAlbum = new Albums();

    newAlbum.owner_id = userId;
    newAlbum.name = createAlbumDto.name;
    if (createAlbumDto.description) newAlbum.description = createAlbumDto.description;
    if (createAlbumDto.visibility) newAlbum.visibility = createAlbumDto.visibility;

    const savedAlbum = await this.albumsRepository.save(newAlbum);

    return {
      status: 'success',
      message: 'Album created successfully',
      data: savedAlbum,
    };
  }

  async findAll(owner_id?: number) {
    const where: any = { is_deleted: 0 };

    if (owner_id) {
      where.owner_id = owner_id;
    }

    const results = await this.albumsRepository.find({
      where,
      order: { createdAt: 'DESC' },
    });

    return {
      status: 'success',
      data: results,
    };
  }

  async findOne(id: number) {
    const album = await this.albumsRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!album) {
      throw new BadRequestException('Album not found');
    }

    return {
      status: 'success',
      data: album,
    };
  }

  async update(updateAlbumDto: UpdateAlbumDto, id: number) {
    const { ...rest } = updateAlbumDto;

    const existingAlbum = await this.albumsRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!existingAlbum) {
      throw new BadRequestException('Album not found');
    }

    await this.albumsRepository.update({ id }, rest);

    return {
      status: 'success',
      message: 'Album updated successfully',
    };
  }

  async remove(id: number) {
    const existingAlbum = await this.albumsRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!existingAlbum) {
      throw new BadRequestException('Album not found');
    }

    await this.albumsRepository.update({ id }, { is_deleted: 1 });

    return {
      status: 'success',
      message: 'Album deleted successfully',
    };
  }

  async search(owner_id: number, searchTerm: string) {
    const where: any = {
      is_deleted: 0,
      owner_id,
    };

    if (searchTerm) {
      where.name = Like(`%${searchTerm}%`);
    }

    const results = await this.albumsRepository.find({
      where,
      order: { createdAt: 'DESC' },
    });

    return {
      status: 'success',
      data: results,
    };
  }
}
