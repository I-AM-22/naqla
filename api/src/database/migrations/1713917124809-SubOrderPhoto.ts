import { MigrationInterface, QueryRunner } from "typeorm";

export class SubOrderPhoto1713917124809 implements MigrationInterface {
    name = 'SubOrderPhoto1713917124809'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "sub_orders_photos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "createdAt" TIMESTAMP NOT NULL DEFAULT now(), "updatedAt" TIMESTAMP NOT NULL DEFAULT now(), "deletedAt" TIMESTAMP, "publicId" character varying NOT NULL, "blurHash" character varying NOT NULL, "profileUrl" character varying NOT NULL, "mobileUrl" character varying NOT NULL, "webUrl" character varying NOT NULL, "subOrderId" uuid NOT NULL, CONSTRAINT "PK_69f93c7ca39f0ad7dd355490119" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "sub_orders_photos" ADD CONSTRAINT "FK_1ab058fa1c6414969e436d369fa" FOREIGN KEY ("subOrderId") REFERENCES "sub_orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "sub_orders_photos" DROP CONSTRAINT "FK_1ab058fa1c6414969e436d369fa"`);
        await queryRunner.query(`DROP TABLE "sub_orders_photos"`);
    }

}
