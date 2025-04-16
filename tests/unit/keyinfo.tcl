start_server {tags {"keyinfo"} overrides {keyinfo-num-elements-larger-than 2 keyinfo-large-num-elements-max-len 128}} {
    test {KEYINFO - check that it starts with an empty log} {
        r keyinfo reset many-elements
        assert_equal [r keyinfo len many-elements] 0
    }

    test {KEYINFO - string} {
        r keyinfo reset many-elements
        
        r set key-string 1
        assert_equal [r keyinfo len many-elements] 0
        r set key-string 12
        assert_equal [r keyinfo len many-elements] 0
        r set key-string 123
        assert_equal [r keyinfo len many-elements] 1

        set e [lindex [r keyinfo get -1 many-elements] 0]
        assert_equal [llength $e] 4
        assert_equal [lindex $e 1] {key-string}
        assert_equal [expr {[lindex $e 2] == 3}] 1

        r del key-string
        assert_equal [r keyinfo len many-elements] 0
    }

    test {KEYINFO - hash} {
        r keyinfo reset many-elements
        
        r hset key-hash f1 v1
        assert_equal [r keyinfo len many-elements] 0
        r hset key-hash f2 v2
        assert_equal [r keyinfo len many-elements] 0
        r hset key-hash f3 v3
        assert_equal [r keyinfo len many-elements] 1

        set e [lindex [r keyinfo get -1 many-elements] 0]
        assert_equal [llength $e] 4
        assert_equal [lindex $e 1] {key-hash}
        assert_equal [expr {[lindex $e 2] == 3}] 1

        r hdel key-hash f3
        assert_equal [r keyinfo len many-elements] 0
    }

    test {KEYINFO - list} {
        r keyinfo reset many-elements
        
        r lpush key-list m1
        assert_equal [r keyinfo len many-elements] 0
        r lpush key-list m2
        assert_equal [r keyinfo len many-elements] 0
        r lpush key-list m3
        assert_equal [r keyinfo len many-elements] 1

        set e [lindex [r keyinfo get -1 many-elements] 0]
        assert_equal [llength $e] 4
        assert_equal [lindex $e 1] {key-list}
        assert_equal [expr {[lindex $e 2] == 3}] 1

        r lpop key-list
        assert_equal [r keyinfo len many-elements] 0
    }

    test {KEYINFO - set} {
        r keyinfo reset many-elements
        
        r sadd key-set m1
        assert_equal [r keyinfo len many-elements] 0
        r sadd key-set m2
        assert_equal [r keyinfo len many-elements] 0
        r sadd key-set m3
        assert_equal [r keyinfo len many-elements] 1

        set e [lindex [r keyinfo get -1 many-elements] 0]
        assert_equal [llength $e] 4
        assert_equal [lindex $e 1] {key-set}
        assert_equal [expr {[lindex $e 2] == 3}] 1

        r srem key-set m3
        assert_equal [r keyinfo len many-elements] 0
    }

    test {KEYINFO - zset} {
        r keyinfo reset many-elements
        
        r zadd key-zset 1 m1
        assert_equal [r keyinfo len many-elements] 0
        r zadd key-zset 2 m2
        assert_equal [r keyinfo len many-elements] 0
        r zadd key-zset 3 m3
        assert_equal [r keyinfo len many-elements] 1

        set e [lindex [r keyinfo get -1 many-elements] 0]
        assert_equal [llength $e] 4
        assert_equal [lindex $e 1] {key-zset}
        assert_equal [expr {[lindex $e 2] == 3}] 1

        r zrem key-zset m3
        assert_equal [r keyinfo len many-elements] 0
    }
}
