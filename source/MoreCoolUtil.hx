class MoreCoolUtil
{
    public static function getMinAndMax(value1:Float, value2:Float):Array<Float>
	{
		var minAndMaxs = [];

		var min = Math.min(value1, value2);
		var max = Math.max(value1, value2);

		minAndMaxs.push(min);
		minAndMaxs.push(max);

		return minAndMaxs;
	}
}