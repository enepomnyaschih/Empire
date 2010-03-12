package empire.province
{
	import common.Collection;

	public class ProvinceCollection extends Collection
	{
		public function getProvinceAt(index:int):Province
		{
			return Province(getItemAt(index));
		}
	}
}