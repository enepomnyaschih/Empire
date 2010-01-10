#ifndef __WORLD_MODEL__
#define __WORLD_MODEL__

namespace game
{
	/*******************************************************
	  Full information about world current state.
	  All methods are optimised and take constant time
	    (if not specified opposite).
	*******************************************************/
	class WorldModel
	{
	public:
		/*******************************************************
		  Simplest functions
		*******************************************************/

		// Zero based turn number
		virtual int GetTurnNumber() const = 0;

		// Total players count
		virtual int GetPlayerCount() const = 0;

		// Player gold amount on turn begin
		virtual int GetPlayerGold(int player) const = 0;

		// Total count of provinces
		virtual int GetProvinceCount() const = 0;

		// Count of provinces which are neighbouring to specified
		virtual int GetProvinceNeighbourCount(int province) const = 0;

		// Name-number of neighbouring province (for loops)
		virtual int GetProvinceNeighbour(int province, int number) const = 0;

		// Whether the river divides two neighbouring provinces
		virtual bool IsRiver(int province1, int province2) const = 0;

		// The province number, -1 if neutral
		virtual int GetProvinceOwner(int province) const = 0;

		// The province income gold amount per turn
		virtual int GetProvinceIncome(int province) const = 0;

		// Count of units which can be trained in the province per turn
		virtual int GetProvinceRecruitCount(int province, int unitType) const = 0;

		// Count of units in the province
		virtual int GetProvinceUnitCount(int province, int unitType) const = 0;

		// Level of fortification in province
		virtual int GetProvinceFortLevel(int province) const = 0;

		// Hitpoints of fortification in province
		virtual int GetProvinceFortHealth(int province) const = 0;



		/*******************************************************
		  Additional functions.

		  These functions are optimised maximally, that's why
		  using they is recommended.
		*******************************************************/

		// Is player still in the game
		virtual int IsPlayerEmpireAlive(int player) const = 0;

		// Count of provinces of player
		virtual int GetPlayerProvinceCount(int player) const = 0;

		// Count of boundary provinces of player
		virtual int GetPlayerBoundaryProvinceCount(int player) const = 0;

		// Count of non-boundary provinces of player
		virtual int GetPlayerInsideProvinceCount(int player) const = 0;

		// Is the province in the boundary
		virtual bool IsProvinceBoundary(int province) const = 0;

		// Distance to the nearest boundary province
		virtual int GetProvinceDistanceToBoundary(int province) const = 0;

		// Nearest boundary province
		virtual int GetNearestBoundary(int province) const = 0;

		// Are two specified provinces neighbouring
		virtual bool AreProvincesNeighbour(int province1, int province2) const = 0;

		// Distance between provinces.
		// If the provinces have the same owner and onlyOwn = true then
		// only this player's provinces will take part in algorithm.
		// Takes linear time from total province count.
		// Returns -1 if way is not found.
		virtual int GetProvinceDistance(int province1, int province2, bool onlyOwn = false) const = 0;

		// Count of enemy provinces which are neighbours of this province
		virtual int GetEnemyNeighbourCount(int province) const = 0;

		// Count of ally provinces which are neighbours of this province
		virtual int GetAllyNeighbourCount(int province) const = 0;

		// Total player income from all provinces
		virtual int GetPlayerIncome(int player) const = 0;

		// Total recruit count of specified type from all provinces.
		// Pass unitType = -1 to get total recruit count of all types
		virtual int GetPlayerRecruitCountOfType(int player, int unitType) const = 0;

		// Total unit count of specified type from all provinces.
		// Pass unitType = -1 to get total unit count of all types
		virtual int GetPlayerUnitCountOfType(int player, int unitType) const = 0;

		// Fortification repair duration in province
		virtual int GetProvinceFortRepairTime(int province) const = 0;

		// Fortification building/upgrading duration in province (if started)
		virtual int GetProvinceFortBuildTime(int province) const = 0;

	}; // WorldModel

} // game

#endif // __WORLD_MODEL__
