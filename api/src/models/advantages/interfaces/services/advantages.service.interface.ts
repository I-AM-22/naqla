import { CreateAdvantageDto, UpdateAdvantageDto } from '../../dto';
import { Advantage } from '../../entities/advantage.entity';

export interface IAdvantagesService {
  find(): Promise<Advantage[]>;

  findInIds(ids: string[]): Promise<Advantage[]>;

  findOne(id: string): Promise<Advantage>;

  create(createAdvantageDto: CreateAdvantageDto): Promise<Advantage>;

  update(id: string, updateAdvantageDto: UpdateAdvantageDto): Promise<Advantage>;

  disactive(id: string): Promise<void>;

  delete(id: string): Promise<void>;
}
