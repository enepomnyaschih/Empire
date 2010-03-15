package empire.province
{
	import common.collection.Collection;

	public class ProvinceControllerCollection extends Collection
	{
		public function getProvinceControllerAt(index:int):ProvinceController
		{
			return ProvinceController(getItemAt(index));
		}
	}
}