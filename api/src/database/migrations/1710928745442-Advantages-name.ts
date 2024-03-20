import { MigrationInterface, QueryRunner } from "typeorm";

export class AdvantagesName1710928745442 implements MigrationInterface {
    name = 'AdvantagesName1710928745442'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "advantages" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "name" character varying NOT NULL, "cost" numeric(10,2) NOT NULL, "active" boolean NOT NULL DEFAULT true, CONSTRAINT "UQ_9cca6c41085c8dc997026337c73" UNIQUE ("name"), CONSTRAINT "PK_3b41f5da17be4578843e9482ff9" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "cars_advantages_advantages" ("carsId" uuid NOT NULL, "advantagesId" uuid NOT NULL, CONSTRAINT "PK_2afe3bbbb0d9510c1109ce36f58" PRIMARY KEY ("carsId", "advantagesId"))`);
        await queryRunner.query(`CREATE INDEX "IDX_e07f4b64a761901c6db53f1639" ON "cars_advantages_advantages" ("carsId") `);
        await queryRunner.query(`CREATE INDEX "IDX_7bd4dcc92d4291d6c25e78e00d" ON "cars_advantages_advantages" ("advantagesId") `);
        await queryRunner.query(`ALTER TABLE "cars_advantages_advantages" ADD CONSTRAINT "FK_e07f4b64a761901c6db53f1639f" FOREIGN KEY ("carsId") REFERENCES "cars"("id") ON DELETE CASCADE ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "cars_advantages_advantages" ADD CONSTRAINT "FK_7bd4dcc92d4291d6c25e78e00d3" FOREIGN KEY ("advantagesId") REFERENCES "advantages"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "cars_advantages_advantages" DROP CONSTRAINT "FK_7bd4dcc92d4291d6c25e78e00d3"`);
        await queryRunner.query(`ALTER TABLE "cars_advantages_advantages" DROP CONSTRAINT "FK_e07f4b64a761901c6db53f1639f"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_7bd4dcc92d4291d6c25e78e00d"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_e07f4b64a761901c6db53f1639"`);
        await queryRunner.query(`DROP TABLE "cars_advantages_advantages"`);
        await queryRunner.query(`DROP TABLE "advantages"`);
    }

}
