apply(Array.prototype, {
    // Executes a function on each item in the array.
    // 
    // callback(item, index, array)
    each: function(callback, scope)
    {
        for (var i = 0; i < this.length; ++i)
            callback.call(scope || this, this[i], i, this);
    },
    
    // Executes a test function on each item in the array until an item is
    // reached that returns false for the specified function.
    // 
    // callback(item, index, array)
    every: function(callback, scope)
    {
        for (var i = 0; i < this.length; ++i)
            if (!callback.call(scope || this, this[i], i, this))
                return false;
        
        return true;
    },
    
    // Executes a test function on each item in the array and constructs a new
    // array for all items that return true for the specified function.
    // 
    // callback(item, index, array)
    filter: function(callback, scope)
    {
        var result = [];
        
        for (var i = 0; i < this.length; ++i)
            if (callback.call(scope || this, this[i], i, this))
                result.push(this[i]);
        
        return result;
    },
    
    // Executes a test function on each item in the array and constructs a new
    // array for indices of all items that return true for the specified function.
    // 
    // callback(item, index, array)
    filterIndices: function(callback, scope)
    {
        var result = [];
        
        for (var i = 0; i < this.length; ++i)
            if (callback.call(scope || this, this[i], i, this))
                result.push(i);
        
        return result;
    },
    
    // Searches for an item in an array by using strict equality (===) and
    // returns the index position of the item.
    // 
    // from <= to
    indexOf: function(item, from, to)
    {
        from    = (from === undefined ? 0 : from);
        to      = (to   === undefined ? this.length : to);
        
        for (var i = from; i < to; ++i)
            if (this[i] === item)
                return i;
        
        return -1;
    },
    
    // Searches for an item in an array, working backward from the last item,
    // and returns the index position of the matching item using strict
    // equality (===).
    // 
    // from <= to
    lastIndexOf: function(item, from, to)
    {
        from    = (from === undefined ? 0 : from);
        to      = (to   === undefined ? this.length : to);
        
        for (var i = to - 1; i >= from; --i)
            if (this[i] === item)
                return i;
        
        return -1;
    },
    
    // Executes a function on each item in an array, and constructs a new
    // array of items corresponding to the results of the function on each
    // item in the original array.
    // 
    // callback(item, index, array)
    map: function(callback, scope)
    {
        var result = [];
        
        for (var i = 0; i < this.length; ++i)
            result.push(callback.call(scope || this, this[i], i, this));
        
        return result;
    },
    
    // Executes a test function on each item in the array until an item is
    // reached that returns true.
    // 
    // callback(item, index, array)
    some: function(callback, scope)
    {
        for (var i = 0; i < this.length; ++i)
            if (callback.call(scope || this, this[i], i, this))
                return true;
        
        return false;
    },
    
    // Sorts the elements in an array according to one or more fields in the
    // array.
    sortOn: function(key, sortFunc, scope)
    {
        function primFunc(a, b)
        {
            return sortFunc(a[key], b[key]);
        }
        
        sortFunc = sortFunc || compare;
        
        return this.sort(primFunc);
    }
});
