import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { ADVANTAGE_TYPES } from '../interfaces/type';
import { CreateAdvantageDto, UpdateAdvantageDto } from '../dto';
import { Advantage } from '../entities/advantage.entity';
import { IAdvantageRepository } from '../interfaces/repositories/advantage.repository.interface';
import { IAdvantagesService } from '../interfaces/services/advantages.service.interface';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';

@Injectable()
export class AdvantagesService implements IAdvantagesService {
  constructor(
    @Inject(ADVANTAGE_TYPES.repository)
    private readonly advantageRepository: IAdvantageRepository,
  ) {}

  async find(): Promise<Advantage[]> {
    return this.advantageRepository.findAll();
  }

  async findInIds(ids: string[]): Promise<Advantage[]> {
    const advantages = await this.advantageRepository.findInIds(ids);
    if (advantages.length !== ids.length)
      throw new NotFoundException(item_not_found(Entities.Advantage));
    return advantages;
  }

  async findOne(id: string): Promise<Advantage> {
    const advantage = await this.advantageRepository.findById(id);
    if (!advantage)
      throw new NotFoundException(item_not_found(Entities.Advantage));
    return advantage;
  }

  async create(createAdvantageDto: CreateAdvantageDto): Promise<Advantage> {
    return this.advantageRepository.create(createAdvantageDto);
  }

  async update(
    id: string,
    updateAdvantageDto: UpdateAdvantageDto,
  ): Promise<Advantage> {
    const advantage = await this.findOne(id);
    return this.advantageRepository.update(advantage, updateAdvantageDto);
  }

  async disactive(id: string): Promise<void> {
    const advantage = await this.findOne(id);
    return this.advantageRepository.disactive(advantage);
  }

  async delete(id: string): Promise<void> {
    const advantage = await this.findOne(id);
    return this.advantageRepository.delete(advantage);
  }
}
