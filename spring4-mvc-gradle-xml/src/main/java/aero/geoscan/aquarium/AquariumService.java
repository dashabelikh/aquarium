package aero.geoscan.aquarium;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class AquariumService {
	public String getDesc() {

		return "AQUARIUM";

	}

	public String getTitle(String name) {

		if (StringUtils.isEmpty(name)) {
			return getDesc();
		} else {
			return "Hello, " + name + ". This is an " + getDesc();
		}

	}

	public String calculate(int[] amountOfCubes) {

		if (amountOfCubes == null)
			return "";

		return new AquariumModel().calculateWater(amountOfCubes);

	}
}
