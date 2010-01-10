#ifndef __COMMAND_MODEL__
#define __COMMAND_MODEL__

namespace game
{
	/*******************************************************
	  Empire controlling tools
	*******************************************************/
	class CommandModel
	{
	public:
		/*******************************************************
		  Current orders information
		*******************************************************/

		// Zero based player number
		virtual int GetPlayerNumber() const = 0;

		// Current gold amount (minus all orders' cost)
		virtual int GetGoldRemaining() const = 0;

		// Current gold spent (orders' cost)
		virtual int GetGoldSpent() const = 0;

		// Current recruits count available in province
		virtual int GetProvinceRecruitCountRemaining(int province, int unitType) const = 0;

		// Current recruits ordered to train in province in current turn
		virtual int GetProvinceRecruitCountTrained(int province, int unitType) const = 0;

		// Current available units count in province
		virtual int GetProvinceUnitCountRemaining(int province, int unitType) const = 0;

		// Units count which will come into province on the next turn
		virtual int GetProvinceUnitCountComing(int province, int unitType) const = 0;

		// Units count which will be available in province on the next turn
		virtual int GetProvinceUnitCountPlanning(int province, int unitType) const = 0;

		// Units ordered to march from one province to another
		virtual int GetUnitCount(int sourceProvince, int targetProvince, int unitType) const = 0;

		/*******************************************************
		  Issue orders
		*******************************************************/

		// Issue order to march from one province to another.
		//
		// Pass unitCount = -1 to issue order for all units of specified type.
		// Pass unitType = -1 also to issue order for all units of all types.
		//
		// If the provinces are not neighbouring, then the most short way will be selected
		// across the allied provinces. The order will not be issued on the next turn
		// automatically.
		//
		// Returns false if either there is no way to target province, or not enough money
		// to march. If enough money to move less units than unitCount, then these units
		// will be moved but the function will return false.
		virtual bool IssueMoveOrder(
			int sourceProvince,
			int targetProvince,
			int unitType,
			int unitCount) = 0;

		// Train units in province.
		//
		// Pass unitCount = -1 to train all available units of specified type.
		// Pass unitType = -1 also to train all available units of all types.
		//
		// Returns false if either not enough money, or not enough recruits. If enough money
		// or recriuts to train less units than unitCount, then these units will be trained
		// but the function will return false.
		virtual bool IssueTrainOrder(
			int province,
			int unitType,
			int unitCount) = 0;

		// Upgrade province fortifications.
		//
		// Returns false if either not enough money, or fortification is maximally upgraded
		// and repaired.
		virtual bool IssueFortifyOrder(
			int province) = 0;

	}; // CommandModel

} // game

#endif // __COMMAND_MODEL__
