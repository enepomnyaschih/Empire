package game.province
{
	import common.Collection;

	public class ProvinceControllerCollection extends Collection
	{
		public function getProvinceControllerAt(index:int):ProvinceController
		{
			return ProvinceController(getItemAt(index));
		}
	}
}