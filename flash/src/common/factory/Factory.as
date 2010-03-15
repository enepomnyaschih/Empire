package common.factory
{
	import util.ErrorUtil;
	
	public class Factory
	{
		virtual public function get type():String
		{
			ErrorUtil.throwMsg(ErrorUtil.MUST_OVERRIDE);
		}
	}
}