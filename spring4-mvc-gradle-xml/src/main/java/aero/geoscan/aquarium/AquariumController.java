package aero.geoscan.aquarium;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
// @RequestMapping("/about")
public class AquariumController {

	private final AquariumService aService;

	@Autowired
	public AquariumController(AquariumService aService) {
		this.aService = aService;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Map<String, Object> model) {

		int[] empty = { -1, -1, -1, -1, -1 };
		model.put("title", aService.getTitle(""));
		model.put("msg", aService.getDesc());
		model.put("coordinatesOfWaterCubes", aService.calculate(null));
		model.put("selectedCubes", empty);

		return "index";

	}

	@RequestMapping(value = "/calculate/{amountOfCubes}", method = RequestMethod.GET)
	public String calcucale(@PathVariable(value = "amountOfCubes") int[] amountOfCubes, Map<String, Object> model) {

		model.put("title", aService.getTitle(""));
		model.put("coordinatesOfWaterCubes", aService.calculate(amountOfCubes));
		model.put("selectedCubes", amountOfCubes);

		// return "redirect:" + request.getHeader("referer");
		return "index";
		// return "redirect:";
	}

	@RequestMapping(value = "/hello/{name:.+}", method = RequestMethod.GET)
	public ModelAndView hello(@PathVariable("name") String name) {

		ModelAndView model = new ModelAndView();
		model.setViewName("index");

		model.addObject("title", aService.getTitle(name));
		model.addObject("msg", aService.getDesc());

		return model;

	}
}