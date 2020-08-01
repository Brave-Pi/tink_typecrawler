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
		return BuildCache.getType('cases.TestRouter', doRun);
	}

	static function doRun(ctx:BuildContext) {
		var name = ctx.name;
		var type = ctx.type.toComplex().toString();
		var cl = macro class $name {
			var prev:String;
			var name:String;

			public function new(prev:String, name:String) {
				this.prev = prev;
				this.name = name;
			}
        };
        var fields = tink.typegen.Crawler.crawl(ctx.type, (macro null).pos, new RouterGen()).ret;
		cl.fields = cl.fields.concat(fields);
        trace(cl.fields);

		return cl;
	}
}

class RouterGen extends Gen {
    function prim(type:String) {
        var tmp = macro class {
			@:get('/')
			public function get(ctx:tink.web.routing.Context) {
                trace(ctx);
				return "Drill(" + prev + " , " + name + " , " + $v{type} + " )";
			}
		};
		return tmp.fields;
    }
	override function int() {
		return prim('Int');
    }
    override function float() {
        return prim("Float");
    }

	override function string():Array<Field>
		return [];

	override function enumAbstract(names:Array<Expr>, e:Array<Field>, ct:ComplexType, pos:Position):Array<Field>
		return [];
}
#end
