import { ApiProperty } from '@nestjs/swagger';

export class LocationStart {
  @ApiProperty()
  region: string;

  @ApiProperty()
  street: string;

  @ApiProperty()
  latitude: number;

  @ApiProperty()
  longitude: number;
}

export class LocationEnd {
  @ApiProperty()
  region: string;

  @ApiProperty()
  street: string;

  @ApiProperty()
  latitude: number;

  @ApiProperty()
  longitude: number;
}

export class Advantage {
  @ApiProperty()
  id: string;

  @ApiProperty()
  name: string;
}

export class Photo {
  @ApiProperty()
  id: string;

  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  updatedAt: string;

  @ApiProperty()
  blurHash: string;

  @ApiProperty()
  profileUrl: string;

  @ApiProperty()
  mobileUrl: string;

  @ApiProperty()
  webUrl: string;

  @ApiProperty()
  weight: number;

  @ApiProperty()
  length: number;

  @ApiProperty()
  width: number;
}

export class Order {
  @ApiProperty()
  id: string;

  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  updatedAt: string;

  @ApiProperty()
  desiredDate: string;

  @ApiProperty()
  status: string;

  @ApiProperty()
  porters: number;

  @ApiProperty()
  locationStart: LocationStart;

  @ApiProperty()
  locationEnd: LocationEnd;

  @ApiProperty()
  advantages: number;
}

export class Driver {
  @ApiProperty()
  id: string;

  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  updatedAt: string;

  @ApiProperty()
  firstName: string;

  @ApiProperty()
  lastName: string;
}

export class Car {
  @ApiProperty()
  id: string;

  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  updatedAt: string;

  @ApiProperty()
  model: string;

  @ApiProperty()
  brand: string;

  @ApiProperty()
  color: string;

  @ApiProperty()
  driver: Driver;
}

export class OrderSubOrder {
  @ApiProperty()
  id: string;

  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  updatedAt: string;

  @ApiProperty()
  rating: number;

  @ApiProperty()
  weight: number;

  @ApiProperty()
  cost: number;

  @ApiProperty()
  status: string;

  @ApiProperty()
  acceptedAt: string;

  @ApiProperty()
  arrivedAt: string;

  @ApiProperty()
  deliveredAt: string;

  @ApiProperty()
  driverAssignedAt?: string;

  @ApiProperty()
  pickedUpAt: string;

  @ApiProperty()
  order: Order;

  @ApiProperty()
  photo: Photo;

  @ApiProperty()
  car?: Car;
}
