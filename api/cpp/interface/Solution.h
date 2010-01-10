#ifndef __SOLUTION__
#define __SOLUTION__

#include "CommandModel.h"
#include "ObjectModel.h"
#include "WorldModel.h"

namespace game
{
	class Solution
	{
	public:
		// Run AI in another turn
		virtual void Run(
			WorldModel &world,
			CommandModel &command) = 0;

	}; // Solution

} // game

#endif // __SOLUTION__
