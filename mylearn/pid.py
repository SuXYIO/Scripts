from matplotlib import pyplot as plt
import random


class generalSystem:
    def __init__(self, initialStat: float, errorFunc):
        self.status = initialStat
        self.errorFunc = errorFunc

    def control(self, force: float):
        self.status += force + self.errorFunc()

    def getStatus(self) -> float:
        return self.status


def pidController(
    system: generalSystem,
    expected: float,
    acceptableError: float,
    kp: float,
    ki: float,
    kd: float,
) -> dict[str, list[float]]:
    def error(system: generalSystem, expected):
        return expected - system.getStatus()

    vp, vi, vd, lastvp = 0, 0, 0, 0
    log = {"vp": [], "vi": [], "vd": [], "stat": [], "err": [], "force": []}

    while abs(err := error(system, expected)) >= acceptableError:
        # calc
        vp = err
        vi += vp
        vd = vp - lastvp
        lastvp = vp

        # add
        oldstat = system.getStatus()
        force = kp * vp + ki * vi + kd * vd
        system.control(force)

        # log
        log["vp"].append(vp)
        log["vi"].append(vi)
        log["vd"].append(vd)
        log["stat"].append(oldstat)
        log["err"].append(err)
        log["force"].append(force)

    return log


if __name__ == "__main__":
    expected = 20
    system1 = generalSystem(0, lambda: -10)
    log1 = pidController(system1, expected, 0.01, 0.4, 0.05, 0.1)
    system2 = generalSystem(0, lambda: -10)
    log2 = pidController(system2, expected, 0.01, 0.25, 0.05, 0.1)

    fig = plt.figure()
    show = "stat"
    ax1 = plt.subplot(121)
    loglen = len(log1["stat"])
    ax1.plot([expected] * loglen, label="expected")
    for label, value in log1.items():
        if label in show:
            ax1.plot(value, label=label)
    ax2 = plt.subplot(122)
    loglen = len(log2["stat"])
    ax2.plot([expected] * loglen, label="expected")
    for label, value in log2.items():
        if label in show:
            ax2.plot(value, label=label)

    plt.legend()
    plt.show()
