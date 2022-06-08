import { DateTime } from "luxon";
import { BaseModel, column, HasOne, hasOne } from "@ioc:Adonis/Lucid/Orm";
import Image from "./Image";

export default class Link extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public libelle: string;

  @column()
  public path: string;

  @hasOne(() => Image)
  public images: HasOne<typeof Image>;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime;
}
