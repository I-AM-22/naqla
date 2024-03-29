import { MigrationInterface, QueryRunner } from 'typeorm';

export class Order1711277457409 implements MigrationInterface {
  name = 'Order1711277457409';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "orders_photos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "publicId" character varying NOT NULL, "blurHash" character varying NOT NULL, "profileUrl" character varying NOT NULL, "mobileUrl" character varying NOT NULL, "webUrl" character varying NOT NULL, "orderId" uuid NOT NULL, CONSTRAINT "PK_327be8527e55fae040a4dba998a" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "orders" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "desiredDate" TIMESTAMP NOT NULL, "status" character varying NOT NULL, "cost" integer NOT NULL, "locationStart" jsonb, "locationEnd" jsonb, "userId" uuid NOT NULL, CONSTRAINT "PK_710e2d4957aa5878dfe94e4ac2f" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "advantages" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "name" character varying NOT NULL, "cost" numeric(10,2) NOT NULL, "active" boolean NOT NULL DEFAULT true, CONSTRAINT "UQ_9cca6c41085c8dc997026337c73" UNIQUE ("name"), CONSTRAINT "PK_3b41f5da17be4578843e9482ff9" PRIMARY KEY ("id"))`,
    );
    await queryRunner.query(
      `CREATE TABLE "orders_advantages" ("ordersId" uuid NOT NULL, "advantagesId" uuid NOT NULL, CONSTRAINT "PK_479fbdb73f548a70335dae4a1f1" PRIMARY KEY ("ordersId", "advantagesId"))`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_1c5daae6129df63f9a41a8d97e" ON "orders_advantages" ("ordersId") `,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_9c3c05d74b8809a83409b5c81d" ON "orders_advantages" ("advantagesId") `,
    );
    await queryRunner.query(
      `CREATE TABLE "cars_advantages" ("carsId" uuid NOT NULL, "advantagesId" uuid NOT NULL, CONSTRAINT "PK_df887fde0e193836aff5bd79a22" PRIMARY KEY ("carsId", "advantagesId"))`,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_5bc2c6cef1d463eebf2116df20" ON "cars_advantages" ("carsId") `,
    );
    await queryRunner.query(
      `CREATE INDEX "IDX_190ac39adcc281ba12a261e03f" ON "cars_advantages" ("advantagesId") `,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" ADD CONSTRAINT "FK_2cdd32f584f2791ed081d2bd8ee" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders" ADD CONSTRAINT "FK_151b79a83ba240b0cb31b2302d1" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_advantages" ADD CONSTRAINT "FK_1c5daae6129df63f9a41a8d97ef" FOREIGN KEY ("ordersId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_advantages" ADD CONSTRAINT "FK_9c3c05d74b8809a83409b5c81d1" FOREIGN KEY ("advantagesId") REFERENCES "advantages"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_advantages" ADD CONSTRAINT "FK_5bc2c6cef1d463eebf2116df20d" FOREIGN KEY ("carsId") REFERENCES "cars"("id") ON DELETE CASCADE ON UPDATE CASCADE`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_advantages" ADD CONSTRAINT "FK_190ac39adcc281ba12a261e03f0" FOREIGN KEY ("advantagesId") REFERENCES "advantages"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "cars_advantages" DROP CONSTRAINT "FK_190ac39adcc281ba12a261e03f0"`,
    );
    await queryRunner.query(
      `ALTER TABLE "cars_advantages" DROP CONSTRAINT "FK_5bc2c6cef1d463eebf2116df20d"`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_advantages" DROP CONSTRAINT "FK_9c3c05d74b8809a83409b5c81d1"`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_advantages" DROP CONSTRAINT "FK_1c5daae6129df63f9a41a8d97ef"`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders" DROP CONSTRAINT "FK_151b79a83ba240b0cb31b2302d1"`,
    );
    await queryRunner.query(
      `ALTER TABLE "orders_photos" DROP CONSTRAINT "FK_2cdd32f584f2791ed081d2bd8ee"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_190ac39adcc281ba12a261e03f"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_5bc2c6cef1d463eebf2116df20"`,
    );
    await queryRunner.query(`DROP TABLE "cars_advantages"`);
    await queryRunner.query(
      `DROP INDEX "public"."IDX_9c3c05d74b8809a83409b5c81d"`,
    );
    await queryRunner.query(
      `DROP INDEX "public"."IDX_1c5daae6129df63f9a41a8d97e"`,
    );
    await queryRunner.query(`DROP TABLE "orders_advantages"`);
    await queryRunner.query(`DROP TABLE "advantages"`);
    await queryRunner.query(`DROP TABLE "orders"`);
    await queryRunner.query(`DROP TABLE "orders_photos"`);
  }
}
