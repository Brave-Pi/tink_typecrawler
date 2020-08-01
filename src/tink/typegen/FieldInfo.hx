package tink.typegen;

import haxe.macro.Expr;
import haxe.macro.Type;

using tink.MacroApi;

typedef FieldAccessInfo = {
  var get(default, never):String;
  var set(default, never):String;
}

class FieldInfo<T> {
  public var name(default, null):String;
  public var pos(default, null):Position;
  public var type(default, null):Type;
  public var access(default, null):FieldAccessInfo;

  public var generated(get, null):T;
    function get_generated() return switch generated {
      case null: generated = as(type);
      case v: v;
    }

  public var optional(default, null):Bool;
  public var meta(default, null):Metadata;

  var gen:Generator.GenType<T>;

  public function as(type:Type):T
    return gen(type, pos);

  public function new(o, gen, optional, meta, ?access) {
    this.name = o.name;
    this.pos = o.pos;
    this.type = o.type;
    this.gen = gen;
    this.optional = optional;
    this.meta = meta;
    this.access = switch access {
      case null: DEFAULT_ACCESS;
      default: access;
    }
  }

  static var DEFAULT_ACCESS:FieldAccessInfo = { get: 'default', set: 'never' };

  public function makeOptional()
    return
      if (this.optional) this;
      else new FieldInfo(this, gen, true, meta, access);

  static public function fieldAccess(c:ClassField):FieldAccessInfo
    return switch c.kind {
      case FVar(read, write):
        { get: read.accessToName(true), set: write.accessToName(false) };
      default:
        { get: 'default', set: 'never' };
    }

  static public function ofClassField(f:ClassField, gen)
    return new FieldInfo(f, gen, f.meta.has(':optional'), f.meta.get(), fieldAccess(f));

}