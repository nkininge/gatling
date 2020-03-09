var stats = {
    type: "GROUP",
name: "Global Information",
path: "",
pathFormatted: "group_missing-name-b06d1",
stats: {
    "name": "Global Information",
    "numberOfRequests": {
        "total": "2",
        "ok": "2",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "2520",
        "ok": "2520",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "2103",
        "ok": "2103",
        "ko": "-"
    },
    "percentiles1": {
        "total": "2520",
        "ok": "2520",
        "ko": "-"
    },
    "percentiles2": {
        "total": "3571",
        "ok": "3571",
        "ko": "-"
    },
    "percentiles3": {
        "total": "4412",
        "ok": "4412",
        "ko": "-"
    },
    "percentiles4": {
        "total": "4580",
        "ok": "4580",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "count": 1,
    "percentage": 50
},
    "group2": {
    "name": "800 ms < t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t > 1200 ms",
    "count": 1,
    "percentage": 50
},
    "group4": {
    "name": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.033",
        "ok": "0.033",
        "ko": "-"
    }
},
contents: {
"req_home-8cf04": {
        type: "REQUEST",
        name: "Home",
path: "Home",
pathFormatted: "req_home-8cf04",
stats: {
    "name": "Home",
    "numberOfRequests": {
        "total": "1",
        "ok": "1",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "0",
        "ok": "0",
        "ko": "-"
    },
    "percentiles1": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "percentiles2": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "percentiles3": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "percentiles4": {
        "total": "4622",
        "ok": "4622",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "count": 0,
    "percentage": 0
},
    "group2": {
    "name": "800 ms < t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t > 1200 ms",
    "count": 1,
    "percentage": 100
},
    "group4": {
    "name": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.017",
        "ok": "0.017",
        "ko": "-"
    }
}
    },"req_home-redirect-1-df14c": {
        type: "REQUEST",
        name: "Home Redirect 1",
path: "Home Redirect 1",
pathFormatted: "req_home-redirect-1-df14c",
stats: {
    "name": "Home Redirect 1",
    "numberOfRequests": {
        "total": "1",
        "ok": "1",
        "ko": "0"
    },
    "minResponseTime": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "maxResponseTime": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "meanResponseTime": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "standardDeviation": {
        "total": "0",
        "ok": "0",
        "ko": "-"
    },
    "percentiles1": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "percentiles2": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "percentiles3": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "percentiles4": {
        "total": "417",
        "ok": "417",
        "ko": "-"
    },
    "group1": {
    "name": "t < 800 ms",
    "count": 1,
    "percentage": 100
},
    "group2": {
    "name": "800 ms < t < 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group3": {
    "name": "t > 1200 ms",
    "count": 0,
    "percentage": 0
},
    "group4": {
    "name": "failed",
    "count": 0,
    "percentage": 0
},
    "meanNumberOfRequestsPerSecond": {
        "total": "0.017",
        "ok": "0.017",
        "ko": "-"
    }
}
    }
}

}

function fillStats(stat){
    $("#numberOfRequests").append(stat.numberOfRequests.total);
    $("#numberOfRequestsOK").append(stat.numberOfRequests.ok);
    $("#numberOfRequestsKO").append(stat.numberOfRequests.ko);

    $("#minResponseTime").append(stat.minResponseTime.total);
    $("#minResponseTimeOK").append(stat.minResponseTime.ok);
    $("#minResponseTimeKO").append(stat.minResponseTime.ko);

    $("#maxResponseTime").append(stat.maxResponseTime.total);
    $("#maxResponseTimeOK").append(stat.maxResponseTime.ok);
    $("#maxResponseTimeKO").append(stat.maxResponseTime.ko);

    $("#meanResponseTime").append(stat.meanResponseTime.total);
    $("#meanResponseTimeOK").append(stat.meanResponseTime.ok);
    $("#meanResponseTimeKO").append(stat.meanResponseTime.ko);

    $("#standardDeviation").append(stat.standardDeviation.total);
    $("#standardDeviationOK").append(stat.standardDeviation.ok);
    $("#standardDeviationKO").append(stat.standardDeviation.ko);

    $("#percentiles1").append(stat.percentiles1.total);
    $("#percentiles1OK").append(stat.percentiles1.ok);
    $("#percentiles1KO").append(stat.percentiles1.ko);

    $("#percentiles2").append(stat.percentiles2.total);
    $("#percentiles2OK").append(stat.percentiles2.ok);
    $("#percentiles2KO").append(stat.percentiles2.ko);

    $("#percentiles3").append(stat.percentiles3.total);
    $("#percentiles3OK").append(stat.percentiles3.ok);
    $("#percentiles3KO").append(stat.percentiles3.ko);

    $("#percentiles4").append(stat.percentiles4.total);
    $("#percentiles4OK").append(stat.percentiles4.ok);
    $("#percentiles4KO").append(stat.percentiles4.ko);

    $("#meanNumberOfRequestsPerSecond").append(stat.meanNumberOfRequestsPerSecond.total);
    $("#meanNumberOfRequestsPerSecondOK").append(stat.meanNumberOfRequestsPerSecond.ok);
    $("#meanNumberOfRequestsPerSecondKO").append(stat.meanNumberOfRequestsPerSecond.ko);
}
