import { DateTime } from "luxon";
import { BaseModel, column, HasMany, hasMany } from "@ioc:Adonis/Lucid/Orm";
import Image from "./Image";

export default class Link extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public libelle: string;

  @column()
  public path: string;

  @hasMany(() => Image)
  public images: HasMany<typeof Image>;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime;
}
