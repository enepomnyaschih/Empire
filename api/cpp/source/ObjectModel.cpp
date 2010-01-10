#include "../interface/ObjectModel.h"

namespace game
{
	/*******************************************************
	  Unit types information
	*******************************************************/

	// Leg Phalnx Archer Auxiln Akvist  Chart Catplt   Fort Citadl Frtrss
	const int ObjectModel::unitTypeAttack[UT_COUNT] =
	{   40,    40,    40,    40,    40,    40,    40,    40,    60,    80};

	const int ObjectModel::unitTypeDefence[UT_COUNT] =
	{  100,   100,   100,   100,   100,   100,   100,   300,   700,  1200};

	const int ObjectModel::unitTypeAttackType[UT_COUNT] =
	{    0,     1,     2,     0,     1,     2,     3,     4,     4,     4};

	const int ObjectModel::unitTypeDefenceType[UT_COUNT] =
	{    0,     0,     0,     1,     1,     1,     2,     3,     3,     3};

	const int ObjectModel::unitTypeCost[UT_COUNT] =
	{    4,     4,     4,     6,     6,     6,     4,     6,    14,    24}; 

	const int ObjectModel::unitTypeSpeed[UT_COUNT] =
	{    1,     1,     1,     2,     2,     2,     1,     0,     0,     0};

	const bool ObjectModel::unitTypeAttackAdvanced[UT_COUNT] =
	{false, false, false,  true,  true,  true,  true, false, false, false};

	const bool ObjectModel::unitTypeDefenceAdvanced[UT_COUNT] =
	{false, false, false, false, false, false,  true,  true,  true,  true};

	const bool ObjectModel::unitTypeFortification[UT_COUNT] =
	{false, false, false, false, false, false, false,  true,  true,  true};



	/*******************************************************
	  Fortress levels information
	*******************************************************/

	// Frt Citadl Frtrss
	const int ObjectModel::fortificationLevelAttack[FL_COUNT] =
	{   40,    60,    80};

	const int ObjectModel::fortificationLevelDefence[FL_COUNT] =
	{  300,   700,  1200};

	const int ObjectModel::fortificationLevelCost[FL_COUNT] =
	{    6,    14,    24};

	// Cost of Citadel and Fortress is specified as full cost of
	// all upgrade levels total.



	/*******************************************************
	  (Attack <=> Defence) efficiencies table (%)
	*******************************************************/

	//   Inf  Cav  Veh Fort
	const int ObjectModel::attackTypeCoef[AT_COUNT][DT_COUNT] = {
		{100, 100,  50,  50},		// Sword
		{ 50, 200,  50,  50},		// Spear
		{200,  50,  50,  50},		// Bow
		{ 25,  25,  75, 125},		// Siege
		{100, 100, 100,   0}		// Fort
	};

} // game
