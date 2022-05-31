import { DateTime } from "luxon";
import { BaseModel, column, HasOne, hasOne } from "@ioc:Adonis/Lucid/Orm";
import Link from "./Link";

export default class Image extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public path: string;

  @column()
  public name: string;

  @column()
  public location: string;

  @hasOne(() => Link)
  public imageId: HasOne<typeof Link>;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime;
}
