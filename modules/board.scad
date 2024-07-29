csv_sep = ";";

/*
    Generats a cube and prints the sizes as CSV output via echo. 
    For output, dimensons are sorted to represent a horizontal board.
*/
module board(size=[1,1,1], center=false) {
    function quicksort(arr) = !(len(arr)>0) ? [] : let(
        pivot   = arr[floor(len(arr)/2)],
        lesser  = [ for (y = arr) if (y  < pivot) y ],
        equal   = [ for (y = arr) if (y == pivot) y ],
        greater = [ for (y = arr) if (y  > pivot) y ]
        ) concat(
            quicksort(lesser), equal, quicksort(greater)
        );
    cube(size,center);
    s_size = quicksort(size);
    echo(str("CSV:",s_size[0],csv_sep,s_size[1],csv_sep,s_size[2]));
}

