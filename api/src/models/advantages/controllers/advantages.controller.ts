import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, SerializeOptions } from '@nestjs/common';
import { CreateAdvantageDto } from '../dto/create-advantage.dto';
import { UpdateAdvantageDto } from '../dto/update-advantage.dto';
import { ApiTags, ApiCreatedResponse, ApiOkResponse, ApiNoContentResponse } from '@nestjs/swagger';
import { LoggingInterceptor } from '@common/interceptors';
import { Advantage } from '../entities/advantage.entity';
import { ApiMainErrorsResponse, Auth, Roles } from '@common/decorators';
import { GROUPS, ROLE } from '@common/enums';
import { AdvantagesService } from '../services/advantages.service';

@ApiTags('Advantages')
@ApiMainErrorsResponse()
@UseInterceptors(new LoggingInterceptor())
@Auth()
@Controller({ path: 'advantages', version: '1' })
export class AdvantagesController {
  constructor(private readonly advantagesService: AdvantagesService) {}

  @SerializeOptions({ groups: [GROUPS.ADVANTAGE] })
  @ApiCreatedResponse({ type: Advantage })
  @Roles(ROLE.ADMIN)
  @Post()
  create(@Body() createAdvantageDto: CreateAdvantageDto) {
    return this.advantagesService.create(createAdvantageDto);
  }

  @SerializeOptions({ groups: [GROUPS.ALL_ADVANTAGES] })
  @ApiOkResponse({ type: Advantage, isArray: true })
  @Get()
  findAll() {
    return this.advantagesService.find();
  }

  @SerializeOptions({ groups: [GROUPS.ADVANTAGE] })
  @ApiOkResponse({ type: Advantage })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.advantagesService.findOne(id);
  }

  @SerializeOptions({ groups: [GROUPS.ADVANTAGE] })
  @ApiOkResponse({ type: Advantage })
  @Roles(ROLE.ADMIN)
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateAdvantageDto: UpdateAdvantageDto) {
    return this.advantagesService.update(id, updateAdvantageDto);
  }

  @ApiNoContentResponse()
  @Roles(ROLE.ADMIN)
  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.advantagesService.delete(id);
  }
}
