import { DateTime } from "luxon";
import { BaseModel, column, HasOne, hasOne } from "@ioc:Adonis/Lucid/Orm";
import Link from "./Link";
import Profil from "./Profil";

export default class Image extends BaseModel {
  @column({ isPrimary: true })
  public id: number;

  @column()
  public name: string;

  @column()
  public path: string;

  @column()
  public hardskillId: number;

  @column()
  public softskillId: number;

  @hasOne(() => Link)
  public linkId: HasOne<typeof Link>;

  @hasOne(() => Profil)
  public profilId: HasOne<typeof Profil>;

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime;

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime;
}
