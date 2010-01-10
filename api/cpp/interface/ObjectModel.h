#ifndef __OBJECT_MODEL__
#define __OBJECT_MODEL__

namespace game
{
	enum UnitTypesEnum
	{
		UT_LEGION		= 0,
		UT_PHALANX		= 1,
		UT_ARCHERS		= 2,
		UT_AUXILIAN		= 3,
		UT_AKVISTES		= 4,
		UT_CHARIOT		= 5,
		UT_CATAPULT		= 6,

		UT_FORCECOUNT	= 7,

		UT_FORT			= 7,
		UT_CITADEL		= 8,
		UT_FORTRESS		= 9,

		UT_FORTCOUNT	= 3,

		UT_FORCEFIRST	= 0,
		UT_FORTFIRST	= UT_FORCEFIRST	+ UT_FORCECOUNT,
		UT_COUNT		= UT_FORTFIRST  + UT_FORTCOUNT

	}; // UnitTypesEnum

	enum AttackTypesEnum
	{
		AT_SWORD		= 0,
		AT_SPEAR		= 1,
		AT_BOW			= 2,
		AT_SIEGE		= 3,
		AT_FORT			= 4,

		AT_COUNT

	}; // AttackTypesEnum

	enum DefenceTypesEnum
	{
		DT_INFANTRY		= 0,
		DT_CAVALRY		= 1,
		DT_VEHICLE		= 2,
		DT_FORT			= 3,

		DT_COUNT

	}; // DefenceTypesEnum

	enum FortificationLevelsEnum
	{
		FL_NONE			= 0,
		FL_FORT			= 1,
		FL_CITADEL		= 2,
		FL_FORTRESS		= 3,

		FL_COUNT

	}; // FortificationLevelsEnum

	struct ObjectModel
	{
	public:
		/*******************************************************
		  Unit types information
		*******************************************************/

		// Unit type attack (max damage)
		static const int unitTypeAttack[UT_COUNT];

		// Unit type defence (hitpoints)
		static const int unitTypeDefence[UT_COUNT];

		// Unit type attack type (weapon)
		static const int unitTypeAttackType[UT_COUNT];

		// Unit type defence type (armor)
		static const int unitTypeDefenceType[UT_COUNT];

		// Unit type cost
		static const int unitTypeCost[UT_COUNT];

		// Unit type speed (amount of provinces per turn)
		static const int unitTypeSpeed[UT_COUNT];

		// Can the unit attack unavailable units in enemy force
		static const bool unitTypeAttackAdvanced[UT_COUNT];

		// Is unit unavailable to be attacked while other units are destroyed
		static const bool unitTypeDefenceAdvanced[UT_COUNT];

		// Is the fortification
		static const bool unitTypeFortification[UT_COUNT];



		/*******************************************************
		  Fortress levels information
		*******************************************************/
		// Shorthand to unitTypeAttack for fortification levels
		static const int fortificationLevelAttack[FL_COUNT];

		// Shorthand to unitTypeDefence for fortification levels
		static const int fortificationLevelDefence[FL_COUNT];

		// Shorthand to unitTypeCost for fortification levels
		static const int fortificationLevelCost[FL_COUNT];



		/*******************************************************
		  (Attack <=> Defence) efficiencies table (%)
		*******************************************************/

		static const int attackTypeCoef[AT_COUNT][DT_COUNT];

	}; // ObjectModel

} // game

#endif // __OBJECT_MODEL__
