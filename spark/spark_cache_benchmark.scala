%spark

val cheminHDFS = "/warehouse/tablespace/managed/hive/projet_energie.db/managed_train_parquet"
val df = spark.read.parquet(cheminHDFS)


val dfBenchmark = df.groupBy("building_id", "meter_id").avg("meter_reading")


println("========== BENCHMARK SANS CACHE ==========")
for (i <- 1 to 2) {
    val t0 = System.nanoTime()
    val count = dfBenchmark.count() 
    val t1 = System.nanoTime()
    println(s"Passage $i : ${ (t1 - t0) / 1e9 } secondes")
}


println("\n========== BENCHMARK AVEC CACHE ==========")
dfBenchmark.cache() 

for (i <- 1 to 2) {
    val t0 = System.nanoTime()
    val count = dfBenchmark.count()
    val t1 = System.nanoTime()
    println(s"Passage $i : ${ (t1 - t0) / 1e9 } secondes")
}

dfBenchmark.unpersist()
