package empire.province
{
	import com.collections.Collection;

	public class ProvinceControllerCollection extends Collection
	{
		public function getProvinceControllerAt(index:int):ProvinceController
		{
			return ProvinceController(getItemAt(index));
		}
	}
}