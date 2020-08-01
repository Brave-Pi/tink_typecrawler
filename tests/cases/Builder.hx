package cases;
import tink.macro.BuildCache;
import haxe.macro.Context;
import tink.streams.Stream.Generator;
import haxe.macro.Expr;
import haxe.macro.Type;
using tink.MacroApi;
#if macro
class Builder {
    public static function run() {
        return BuildCache.getType('cases.EnumAbstractTest', doRun);
    }
    static function doRun(ctx:BuildContext) {
        var name = ctx.name;
        var type = ctx.type.toComplex().toString();
        var cl = macro class $name {
            public function new() {
                trace($v{type});
            }
        };
        cl.fields = cl.fields.concat(tink.typecrawler.Crawler.crawl(haxe.macro.Context.getType('cases.EnumAbstractTest.EnumAbstract'), (macro null).pos, (new EnumAbstractGen() : tink.typecrawler.Generator<Array<Field>>)).ret);
        
        return cl;
      }
}

class EnumAbstractGen extends Gen {
  override function string():Array<Field>
    return [];
  override function enumAbstract(names:Array<Expr>, e:Array<Field>, ct:ComplexType, pos:Position):Array<Field>
    return [];
}
#end
