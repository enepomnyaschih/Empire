using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Echo.Util
{
    public class ArrayListUtil
    {
        public static ArrayList Sub(ArrayList list, int index, int count)
        {
            ArrayList result = new ArrayList();
            while (count != 0)
            {
                result.Add(list[index]);
                ++index;
                --count;
            }
            return result;
        }
    }
}
